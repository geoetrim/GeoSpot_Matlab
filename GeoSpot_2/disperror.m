
function disperror(e)

fprintf(' ---------------------------------------------------\n');
if e == 25    
    fprintf('| Bundle adjustment is not available!               |\n');
    fprintf('| No parameter or check point for bundle adjustment!|\n');
    fprintf('| Program terminated! So sorry, be happy :)         |\n');
elseif e == 26
    (' Error: Two or more parameters are linearly dependent!');
end
fprintf(' ---------------------------------------------------\n');