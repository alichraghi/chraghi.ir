#!/bin/bash
set -e

BG_COLOR="#e1ffe7"
FG_COLOR="#a0f59d"
FG_HOVER_COLOR="#80da7d"
TEMPLATE="template.html"

pushd writings > /dev/null
for v in $(find . -type f)
do
    popd > /dev/null
    mkdir -p $(dirname ${v})
    touch ${v}
    cat ${TEMPLATE} > ${v}
    REPLACE_DATA=$(cat writings/${v})
    sed -e '/<!--CONTENT-->/ {' -e "r writings/${v}" -e 'd' -e '}' -i ${v}
    FN=$(basename -- "$v")
    FN=${FN%.*}
    if [[ "$FN" == "index.html"  ]]; then
        FN="Home"
    fi
    FN=${FN//-/" "}
    FN=`echo $FN | tr [A-Z] [a-z] | sed -e 's/^./\U&/g; s/ ./\U&/g'`
    sed "s/\\\\NAME\\\\/${FN}/g" -i ${v}
    html-minifier --collapse-whitespace --remove-comments --remove-optional-tags --remove-redundant-attributes --remove-script-type-attributes --remove-tag-whitespace --use-short-doctype ${v} -o ${v}
    pushd writings > /dev/null
done
popd

cp static/style_template.css static/style.css
sed -i "s/BG_COLOR/${BG_COLOR}/g" static/style.css
sed -i "s/FG_COLOR/${FG_COLOR}/g" static/style.css
sed -i "s/FG_HOVER_COLOR/${FG_HOVER_COLOR}/g" static/style.css

# cp -r "$FILE_PATH"

