function xmlpath()
{
  local expr="${1//\// }"
  local path=()
  local chunk tag data

  while IFS='' read -r -d '<' chunk; do
    IFS='>' read -r tag data <<< "$chunk"

    case "$tag" in
      '?'*) ;;
      '!–-'*) ;;
      '![CDATA['*) data="${tag:8:${#tag}-10}" ;;
      ?*'/') ;;
      '/'?*) unset path[${#path[@]}-1] ;;
      ?*) path+=("$tag") ;;
    esac

    [[ "${path[@]}" == "$expr" ]] && echo "$data"
  done
}
