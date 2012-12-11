addpath (genpath ('.'));

input_path = './data/ORL/'
output_path = './output/'
origin = [input_path, '1/1.bmp']
num_eigenface = 100

load './output/eigenfaces.mat';

T = double(imread(origin));
[height width channels] = size(T);
img = reshape(T, 1, width * height);

img = img - avg;

c = img * W;


for i = 1 : num_eigenface
    rb = W(:, 1:i) * c(1:i)';
    rb = rb + avg';
    rb = reshape(rb, height, width);
    rebuild_filename = [output_path, 'rebuild/', int2str(i), '.jpg'];
    imwrite(mat2gray(rb), rebuild_filename);
end
