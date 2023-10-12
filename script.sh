#!/bin/sh

echo "Welcome to the beginner-friendly Git assistant!"
echo "Please tell me in simple terms what you'd like to do with Git."

# Loop forever until user quits
while true; do
    echo ""
    read -p "Git Command: " cmd

    case "$cmd" in
        "exit" | "quit")
            echo "Goodbye!"
            break
            ;;
            
        "start a new project" | "initialize repository" | "create a new project")
            DIRNAME=$(gum input --placeholder "Enter the directory name for your new project (leave empty for current directory):")
            if [ -z "$DIRNAME" ]; then
                git init
            else
                mkdir "$DIRNAME" && cd "$DIRNAME" && git init
            fi
            ;;
            
        "save my changes" | "commit my changes")
            git add -A
            MSG=$(gum input --placeholder "Enter a message describing your changes:")
            git commit -m "$MSG"
            ;;
            
        "get latest updates" | "pull updates")
            git pull
            ;;
            
        "share my updates" | "push my updates")
            git push
            ;;
            
        "show my changes" | "list changes")
            git status
            ;;
            
        "create a branch" | "make a new branch")
            BRANCH_NAME=$(gum input --placeholder "Enter a name for your new branch:")
            git checkout -b "$BRANCH_NAME"
            ;;
            
        "switch branch" | "change branch")
            BRANCHES=$(git branch | sed 's/* //g')
            TARGET_BRANCH=$(echo "$BRANCHES" | gum filter --placeholder "Choose a branch:")
            git checkout "$TARGET_BRANCH"
            ;;
            
        "show history" | "list commits")
            git log --oneline | less
            ;;

        *)
            echo "I'm sorry, I'm not sure how to do that. Try another command or use 'exit' to quit."
            ;;
    esac
done

