%% Ԥ��
function pred = predict(X, THETA, WEIGHT, unit_num_list)

% ����OUTPUT

OUTPUT = cell(size(unit_num_list, 2), 1);

for i = 2:size(OUTPUT, 1)
    OUTPUT{i} = zeros(unit_num_list(i), 1);
end

pred = [];

% ǰ�򴫲�
for i = 1:size(X, 1)     % ��i������
    OUTPUT{1} = X(i, :)';
    for j = 1:size(OUTPUT, 1) - 1     % ��k��       
        OUTPUT{j + 1} = sigmoid(WEIGHT{j}' * OUTPUT{j} - THETA{j});
    end
    
    [val, index] = max(OUTPUT{end}');
    temp = zeros(1, size(OUTPUT{end}', 2));
    temp(index) = 1;
    pred = [pred; temp];
end

end