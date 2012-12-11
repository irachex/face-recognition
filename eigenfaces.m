input_path = './data/ORL/'
output_path = './output/'
num_training = 7
num_class = 40
num_comp = 100%

X = [];
y = [];
height = 0;
width = 0;


%% read images
for i = 1 : num_class
    subject = int2str(i)
    avg = []
    for j = 1 : num_training
        filename = [input_path, subject, filesep, int2str(j), '.bmp'];
        T = double(imread(filename));

        [height width channels] = size(T);
           
        % greyscale the image if we have 3 channels
        if(channels == 3)
            T = (T(:,:,1) + T(:,:,2) + T(:,:,3)) / 3;
        end
        
        img = reshape(T, 1, width * height);
        avg = [avg; img];
        X = [X; img];
        y = [y; i];
    end
    avg = mean(avg)
    avg_filename = [output_path, 'avg/', subject, '.jpg']
    imwrite(mat2gray(reshape(avg, height, width)), avg_filename);
end
faces = X;
avg = mean(X);
avg_filename = [output_path, 'avg/', 'avg.jpg']
imwrite(mat2gray(reshape(avg, height, width)), avg_filename);

%% pca
mu = mean(X, 2);
X = X - repmat(mu, 1, size(X,2));
S = X * X';
[v D] = eig(S);
d = diag(D);
d_sort = flipud(d);
v_sort = fliplr(v);

%num_comp = size(X, 2) - 1;
W = X' * v_sort(:,1:num_comp) * diag(d_sort(1:num_comp).^(-1/2));

%% eigenfaces
for k = 1 : min(num_comp, num_class)
    img = reshape(W(:,k), height, width);
    eigen_filename = [output_path, 'eigen/', int2str(k), '.jpg'];
    imwrite(mat2gray(img), eigen_filename);
end


%% training
A = faces * W;
Train = [];
for i = 1 : num_class
    si = (i - 1) * num_training + 1;
    ei = i * num_training;
    Train = [Train; mean(A(si:ei,:))];
end


%% save
save([output_path, 'eigenfaces.mat'], 'W', 'avg');
save([output_path, 'train.mat'], 'Train', 'A');
