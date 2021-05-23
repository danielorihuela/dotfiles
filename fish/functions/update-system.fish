# Defined in - @ line 1
function update-system --wraps='sudo apt update && sudo apt upgrade' --description 'alias update-system=sudo apt update && sudo apt upgrade'
  sudo apt update && sudo apt upgrade $argv;
end
