# Defined in - @ line 1
function clean-system --wraps='sudo apt autoremove && sudo apt purge && sudo apt clean && sudo journalctl --vacuum-time=100d' --description 'alias clean-system=sudo apt autoremove && sudo apt purge && sudo apt clean && sudo journalctl --vacuum-time=100d'
  sudo apt autoremove && sudo apt purge && sudo apt clean && sudo journalctl --vacuum-time=100d $argv;
end
