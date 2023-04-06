i#!/bin/bash

folder_path="$1"
suffix="$2"
results_folder_path="./results"

# 結果格納用のフォルダを作成
mkdir -p "${results_folder_path}"

# フォルダ内のファイルを順に処理
find "$folder_path" -type f -print0 | while IFS= read -r -d '' file; do
    if [ -f "$file" ]; then
        # ファイル名を変更
        dirname_path=$(dirname "$file")
        filename=$(basename "$file")
        extension="${filename##*.}"
        filename_no_ext="${filename%.*}"
        new_filename="${filename_no_ext}_${suffix}_${dirname_path##*/}.${extension}"
        new_file_path="${dirname_path}/${new_filename}"
        cp "$file" "$new_file_path"

        # ファイルを移動
        results_path="${results_folder_path}/${filename_no_ext}_${suffix}_${dirname_path##*/}.${extension}"
        echo "File moved to $results_path"
        mv "$new_file_path" "$results_path"
    fi
done

