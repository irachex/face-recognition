load './output/eigenfaces.mat';
load './output/train.mat';
num_testcase = 100;
num_class = 40;
cnt_correct = 0;

for i = 1 : num_testcase
    subject = uint32(rand() * (num_class - 1)) + 1;
    j = uint32(rand() * 2) + 8;
    filename = [input_path, int2str(subject), filesep, int2str(j), '.bmp'];
    T = double(imread(filename));
    [height width channels] = size(T);

    img = reshape(T, 1, width * height);
    y = img * W;

    %% nearest one
    k = num_class
    for j = 1 : k
        mdist(j) = norm(y - Train(j,:));
    end;
    [distances, index] = sort(mdist);
    c = index(1);

    %% knn
    %k = num_class
    %[num_dataset, num_comp] = size(A)
    %for j = 1 : num_dataset
    %    mdist(j) = norm(y - A(j,:));
    %end;
    %[distances, index] = sort(mdist);
    %index = index(1:k);
    %h = histc(index,(1:max(index)));
    %[v,c] = max(h);

    fprintf('predicted=%d, actual=%d\n', c, subject);
    if c == subject
        cnt_correct = cnt_correct + 1;
    end;
end;

fprintf('correct/testcase=%f\n', cnt_correct / num_testcase);
