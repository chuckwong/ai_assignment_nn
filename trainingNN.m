%% ѵ��������
% X, y, unit_num_list������ĳߴ�, ALPHAѧϰ�ٶ�, iteration��������
function [WEIGHT THETA ERROR] = trainingNN(Xtrain, ytrain, unit_num_list, ALPHA, iteration)

%% ��ʼ��Ȩֵ����ֵ

% ���� (��ȥ�����������)
num_hidden_layer = size(unit_num_list, 2) - 2;

% ����Ȩ��
WEIGHT = cell(num_hidden_layer + 1, 1);

for i = 1:size(WEIGHT, 1)
    WEIGHT{i} = random_initialize([unit_num_list(i), unit_num_list(i + 1)], unit_num_list(1));
end

% ������ֵ

THETA = cell(num_hidden_layer + 1, 1);

for i = 1:size(THETA, 1)
    THETA{i} = random_initialize([unit_num_list(i + 1), 1], unit_num_list(1));
end


% �������
ERROR = zeros(iteration, unit_num_list(end));
ERROR_GRAD = cell(num_hidden_layer + 1, 1);

DELTA_WEIGHT = cell(num_hidden_layer + 1, 1);
DELTA_THETA = cell(num_hidden_layer + 1, 1);


%% ����OUTPUT

OUTPUT = cell(size(unit_num_list, 2), 1);

for i = 2:size(OUTPUT, 1)
    OUTPUT{i} = zeros(unit_num_list(i), 1);
end


%% ѵ��

for i = 1:iteration      % ��i�ε���
    alpha = ALPHA * (iteration - i) / (iteration);
    for j = 1:size(Xtrain, 1)     % ��j������
        OUTPUT{1} = Xtrain(j, :)';
        % ǰ�򴫲�
        for k = 1:size(OUTPUT, 1) - 1     % ��k��
            OUTPUT{k + 1} = sigmoid(WEIGHT{k}' * OUTPUT{k} - THETA{k});
        end
        % ���򴫲�
        for k = 1:size(THETA, 1)
            ik = size(THETA, 1) - k + 1; % ����
            % ERROR
            if ik == size(THETA, 1)
                ERROR(i, :) = ytrain(j, :)' - OUTPUT{ik + 1};
                ERROR_GRAD{ik} = OUTPUT{ik + 1} .* (1 - OUTPUT{ik + 1}) .* ERROR(i, :)';
            else
                ERROR_GRAD{ik} = OUTPUT{ik + 1} .* (1 - OUTPUT{ik + 1}) .* (WEIGHT{ik + 1} * ERROR_GRAD{ik + 1});
            end
            % DELTA
            DELTA_WEIGHT{ik} = alpha * OUTPUT{ik} * ERROR_GRAD{ik}';
            DELTA_THETA{ik} = alpha * THETA{ik} .* ERROR_GRAD{ik};
        end
        % ����
        for k = 1:size(THETA, 1)
            WEIGHT{k} = WEIGHT{k} + DELTA_WEIGHT{k};
            THETA{k} = THETA{k} + DELTA_THETA{k};
        end
    end
    if mod(i, 10) == 0 || i == 1
        fprintf('�� %d �ε���...... Error: %.5f   Alpha: %.5f\n', i, sum(ERROR(i, :) .^ 2), alpha);
    end
end


end