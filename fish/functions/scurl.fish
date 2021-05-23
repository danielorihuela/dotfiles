# Defined in - @ line 1
function scurl --wraps='curl --tlsv1.2 --proto https' --description 'alias scurl=curl --tlsv1.2 --proto https'
  curl --tlsv1.2 --proto https $argv;
end
