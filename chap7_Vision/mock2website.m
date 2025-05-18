imagePath = "cropped_image.jpg";
originalPrompt = "Write brief HTML/JS to turn this mock-up into a colorful website, where the jokes are replaced by two real jokes. (Only the code, no markdown, no explanation)";
code = chatVision(originalPrompt, imagePath)
% % Save the code to a file
fileID = fopen('jokewebsite.html', 'w');
fprintf(fileID, '%s', code);
fclose(fileID);