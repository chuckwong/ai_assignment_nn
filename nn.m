%% �������
clear
% �������, ��3��, �ֱ���2,2,3����Ԫ�ɶ���Ϊ[2,2,3]

num_input = 2;
num_output = 2;

unit_num_list = [num_input, 3, 2, num_output];

%% ��ʼ��Ȩֵ����ֵ

% ���� (��ȥ�����������)
num_hidden_layer = size(unit_num_list, 2) - 2;

% ����Ȩ��
WEIGHT = cell(num_hidden_layer + 1, 1);

for i = 1:num_hidden_layer + 1
    WEIGHT{i} = rand(unit_num_list(i), unit_num_list(i + 1));
    WEIGHT{i} = WEIGHT{i} .* 2 - 1; % ������-1,1֮��
    WEIGHT{i} = random_initialize(WEIGHT{i}, num_input);
end

num_WEIGHT = num_hidden_layer + 1;

% ������ֵ

THETA = cell(num_hidden_layer, 1);

for i = 1:num_hidden_layer
    THETA{i} = rand(unit_num_list(i + 1), 1);
    THETA{i} = THETA{i} .* 2 - 1;
    THETA{i} = random_initialize(THETA{i}, num_input);
end

%% 

    


