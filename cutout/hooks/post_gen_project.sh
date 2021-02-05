#!/usr/bin/env bash

function main {
  set -exfu
  find static -type f | while read -r f; do 
    if [[ "$(uname -s)" == "Darwin" ]]; then
      sed -i '' "s#defn#$(cat .project_org)#g; s#podinfo#$(cat .project_name)#g" "$f"
    else
      sed -i "s#defn#$(cat .project_org)#g; s#podinfo#$(cat .project_name)#g" "$f"
    fi
  done
  pushd static
  mv charts/podinfo "charts/$(cat ../.project_name)" || true
  mv cmd/podinfo "cmd/$(cat ../.project_name)" || true
  popd
  mkdir -p "$(cat .project_name)"
  rsync -ia static/. "$(cat .project_name)/."
  rm -rf static
  rm -f .project_{org,name}
}

main "$@"
