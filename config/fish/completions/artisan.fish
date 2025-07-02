# This file is part of the Symfony package.
#
# (c) Fabien Potencier <fabien@symfony.com>
#
# For the full copyright and license information, please view
# https://symfony.com/doc/current/contributing/code/license.html

function _sf_artisan
    set sf_cmd (commandline -o)
    set c (count (commandline -oc))

    set completecmd "$sf_cmd[1]" "_complete" "--no-interaction" "-sfish" "-a1"

    for i in $sf_cmd
        if [ $i != "" ]
            set completecmd $completecmd "-i$i"
        end
    end

    set completecmd $completecmd "-c$c"

    set sfcomplete ($completecmd)

    for i in $sfcomplete
        echo $i
    end
end

complete -c 'artisan' -a '(_sf_artisan)' -f
complete -c 'php' -n '__fish_seen_subcommand_from artisan' -a '(_sf_artisan)' -f
complete -c 'sail' -n '__fish_seen_subcommand_from artisan' -a '(_sf_artisan)' -f  
complete -c 'mise' -n '__fish_seen_subcommand_from run; and __fish_seen_subcommand_from artisan' -a '(_sf_artisan)' -f
