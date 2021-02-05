#!/usr/bin/env bash

function main {
  set -efu
  find static -type f | while read -r f; do sed -i '' "s#defn#$(cat .project_org)#g; s#podinfo#$(cat .project_name)#g" "$f"; done
  pushd static
  mv charts/podinfo "charts/$(cat ../.project_name)" || true
  mv cmd/podinfo "cmd/$(cat ../.project_name)" || true
  popd
  rsync -ia static/. "$(cat .project_name)/."
  rm -rf static
  rm -f .project_{org,name}
}

main "$@"
