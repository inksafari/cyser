#!/usr/bin/env zsh
#
# Create a new repository in GitHub
#
# - https://github.com/kenju/git_shellscript/blob/master/github.sh
# - https://developer.github.com/v3/repos/#create

ghc() {
    username=`git config github.user`
    if [ "$username" = "" ]; then
        echo "Could not find username, run 'git config --global github.user <username>'"
        invalid_credentials=1
    fi
    
    token=`git config github.token`
    if [ "$token" = "" ]; then
        echo "Could not find token, run 'git config --global github.token <token>'"
        invalid_credentials=1
    fi

    if [ "$invalid_credentials" == "1" ]; then
        return 1
    fi

    # repo name
    dir_name=`basename $(pwd)`
    read -p "Do you want to use '$dir_name' as a repo name?(y/n)" answer_dirname

    case $answer_dirname in
        y)
            # use currently dir name as a repo name
            repo_name=$dir_name
            ;;
        n)
            read -p "Enter your new repository name: " repo_name
            if [ "$repo_name" = "" ]; then
                repo_name=$dir_name
            fi
            ;;
        *)
            ;;
    esac

    # create GitHub repo
    echo -n "Creating GitHub repository '$repo_name' ..."
        read -p "Repository Description: " description
        
        curl \
            -u "$username:$token" \
            -H "Content-Type: application/json" \
            -d '{"name":"'$repo_name'", "description":"'$description'"}' \
            -X POST \
            https://api.github.com/user/repos

    # git init
    echo -n "Initialize local Git repository"
        git init
        git remote add origin git@github.com:$username/$repo_name.git > /dev/null 2>&1
    echo "Done."
}
