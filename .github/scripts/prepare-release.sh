#!/usr/bin/env bash
set -Eeuo pipefail

: "${EVENT_NAME:?}"
: "${REF_NAME:?}"
update_lock="${UPDATE_LOCK:-false}"

tag="${INPUT_TAG:-}"
if [ -z "$tag" ]; then
	if [ "$EVENT_NAME" = "push" ]; then
		tag="$REF_NAME"
	else
		tag="v$(date -u +%Y.%m)"
	fi
fi
echo "tag=$tag" >>"${GITHUB_OUTPUT:?}"

# Scheduled/manual runs create the tag at the checked-out commit.
# Pushes made with GITHUB_TOKEN do not trigger further workflows.
if git rev-parse --verify --quiet "refs/tags/$tag" >/dev/null; then
	echo "Tag $tag already exists, using it as-is"
else
	if [ "$update_lock" = "true" ]; then
		branch="$(git symbolic-ref --quiet --short HEAD || true)"
		if [ -z "$branch" ]; then
			echo "::error::Can't update flake.lock from a detached HEAD; run on a branch"
			exit 1
		fi

		echo "Updating flake.lock"
		nix flake update
		if ! git diff --quiet -- flake.lock; then
			git add flake.lock
			git -c user.name="github-actions[bot]" \
				-c user.email="41898282+github-actions[bot]@users.noreply.github.com" \
				commit -m "flake.lock: update inputs"
			git push origin "HEAD:refs/heads/$branch"
		else
			echo "flake.lock is already up to date"
		fi
	fi

	echo "Creating tag $tag"
	git tag "$tag"
	git push origin "refs/tags/$tag"
fi

if draft=$(gh release view "$tag" --json isDraft -q .isDraft 2>/dev/null); then
	if [ "$draft" = "false" ]; then
		echo "::notice::Release $tag is already published, nothing to do"
		echo "skip=true" >>"${GITHUB_OUTPUT:?}"
		exit 0
	fi
	echo "Reusing existing draft release $tag"
else
	gh release create "$tag" \
		--draft \
		--title "$tag" \
		--generate-notes \
		--verify-tag
fi
