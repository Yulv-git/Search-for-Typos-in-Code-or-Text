### 
 # @Author: Shuangchi He / Yulv
 # @Email: yulvchi@qq.com
 # @Date: 2022-04-30 21:46:45
 # @Motto: Entities should not be multiplied unnecessarily.
 # @LastEditors: Shuangchi He
 # @LastEditTime: 2022-06-04 11:04:37
 # @FilePath: /Search-for-Typos/search_typos_exclude_dir_exclude.sh
 # @Description: Search for typos in code or text.
 # Repository: https://github.com/Yulv-git/Search-for-Typos
### 

current_dir=$(cd `dirname $0`; pwd)
target_dir="$1"
exclude_dir="$2"
exclude="$3"

echo "target_dir: ${target_dir}"
echo "exclude_dir: ${exclude_dir}"
echo "exclude: ${exclude}"


# repeated English words
while read item
do
    item2="${item} ${item}"
    echo
    echo "Could the word '${item}' be repeated???"
    grep -r -i -w -n --color=auto "${item2}" ${target_dir} --exclude-dir=${exclude_dir} --exclude=${exclude}
done < ${current_dir}/typos_lib/repeated_English_words.txt


# repeated Chinese characters
while read item
do
    item2="${item}${item}"
    echo
    echo "Could the character '${item}' be repeated???"
    grep -r -n --color=auto "${item2}" ${target_dir} --exclude-dir=${exclude_dir} --exclude=${exclude}
done < ${current_dir}/typos_lib/repeated_Chinese_characters.txt


# typos of English words/strings
while read item
do
    echo
    echo "Could the word/string '${item}' be a typo???"
    grep -r -i -n --color=auto "${item}" ${target_dir} --exclude-dir=${exclude_dir} --exclude=${exclude}
done < ${current_dir}/typos_lib/typos_English_words_strings.txt


# wrong Chinese phrases
while read item
do
    echo
    echo "Is this Chinese phrase '${item}' used wrong???"
    egrep -r -n --color=auto "${item}" ${target_dir} --exclude-dir=${exclude_dir} --exclude=${exclude}
done < ${current_dir}/typos_lib/wrong_Chinese_phrases.txt


# wrong English phrases
while read item
do
    item2=${item//"Space=Blank"/" "}
    echo "Is this English phrase '${item2}' used wrong???"
    grep -r -i -w -n --color=auto "${item2}" ${target_dir} --exclude-dir=${exclude_dir} --exclude=${exclude}
done < ${current_dir}/typos_lib/wrong_English_phrases.txt
