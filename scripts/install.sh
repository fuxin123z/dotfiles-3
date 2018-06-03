#!bin/bash

source ./basic.sh

# echo $file_dotfiles

# 环境检查
sh $file_dotfiles/scripts/bootstrap.sh

brew_install stow || (echo "command failed" && exit 1)

# 遍历所有需要软stow连接的文件
cd $file_dotfiles/.files
echo "stow list: \n$(ls -a)"

for file in `ls -a`; 
do
	if [[ x"$file" == x"." ]] || [[ x"$file" == x".." ]] || [[ x"$file" == x".DS_Store" ]];then
		continue
	fi

	_file=~/${file}
	if [[ -e "$_file" ]] && [[ ! -L "$_file" ]]; then
		backup_file $_file
	elif [[ -e "$_file" ]] && [[ -L "$_file" ]]; then
		echo "rm: $(rm -r -v $_file)"
	fi
done

cd $file_dotfiles

stow -v .files || (echo "command failed" && exit 1)