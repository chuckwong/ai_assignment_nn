%% 王俊皓 2014101027 神经网络作业

%% 输入数据和部分参数
clear;

% 读入数据
DATA = load()

X = [2 2; 
     3 4;
     5 2
     ];
 
y = [1 0; 0 1; 1 0];

% 定义层数, 如3层, 分别有2,2,3个神经元可定义为[2,2,3]
num_input = size(X, 2);
num_output = size(y, 2);
hidden_num_list = [3, ]; % 可修改隐藏层的层数及每层个数
unit_num_list = [num_input, hidden_num_list, num_output];

% 学习速率
ALPHA = 0.1;

% 测试集比例
test_ptage = 0.2;


%% 参数初始化

% 样本数量
m = size(X, 1);
% 训练集数量
m_train = ceil(m * (1 - test_ptage));
% 测试集数量
m_test = m - m_train;

% 打乱样本顺序
sel = randperm(m);
X = X(sel,:); y = y(sel,:);

% 根据比例生成 训练集 和 测试集
Xtrain = X(1:m_train, :); ytrain = y(1:m_train, :);
Xtest = X(m_train+1:end, :); ytest = y(m_train+1:end, :);


unit_num_list





%% 初始化权值和阈值

% 层数 (减去输入层和输出层)
num_hidden_layer = size(unit_num_list, 2) - 2;

% 定义权重
WEIGHT = cell(num_hidden_layer + 1, 1);

for i = 1:size(WEIGHT, 1)
    WEIGHT{i} = random_initialize([unit_num_list(i), unit_num_list(i + 1)], num_input);
end

% 定义阈值

THETA = cell(num_hidden_layer + 1, 1);

for i = 1:size(THETA, 1)
    THETA{i} = random_initialize([unit_num_list(i + 1), 1], num_input);
end


% 定义误差

ERROR = cell(num_hidden_layer + 1, 1);
ERROR_GRAD = cell(num_hidden_layer + 1, 1);

DELTA_WEIGHT = cell(num_hidden_layer + 1, 1);
DELTA_THETA = cell(num_hidden_layer + 1, 1);


%% 定义OUTPUT

OUTPUT = cell(size(unit_num_list, 2), 1);

for i = 2:size(OUTPUT, 1)
    OUTPUT{i} = zeros(unit_num_list(i), 1);
end


%% TEST

iteration = 10;

for i = 1:iteration      % 第i次迭代
    fprintf('第%d次迭代...\n', i);
    for j = 1:m     % 第j个样本
        OUTPUT{1} = X(j, :)';
        % 前向传播
        for k = 1:size(OUTPUT, 1) - 1     % 第k层
            OUTPUT{k + 1} = sigmoid(WEIGHT{k}' * OUTPUT{k} - THETA{k});
        end
        % 后向传播
        for k = 1:size(THETA, 1)
            ik = size(THETA, 1) - k + 1; % 反向
            % ERROR
            if ik == size(THETA, 1)
                ERROR{ik} = y(j, :)' - OUTPUT{ik + 1};
                ERROR_GRAD{ik} = OUTPUT{ik + 1} .* (1 - OUTPUT{ik + 1}) .* ERROR{ik};
            else
                ERROR_GRAD{ik} = OUTPUT{ik + 1} .* (1 - OUTPUT{ik + 1}) .* (WEIGHT{ik + 1} * ERROR_GRAD{ik + 1});
            end
            % DELTA
            DELTA_WEIGHT{ik} = ALPHA * OUTPUT{ik} * ERROR_GRAD{ik}';
            DELTA_THETA{ik} = ALPHA * THETA{ik} .* ERROR_GRAD{ik};
        end
        % 更新
        for k = 1:size(THETA, 1)
            WEIGHT{k} = WEIGHT{k} + DELTA_WEIGHT{k};
            THETA{k} = THETA{k} + DELTA_THETA{k};
        end
    end
end


























