%% ����� 2014101027 ��������ҵ

clear;  % ��������
clc;    % ����

%% �������ݺͲ��ֲ���

fprintf('---- �� 1 �׶�: �������� ----\n\n');

% ��������
[X, y, y_raw, labels] = loadData('iris.txt', ' ');

% �������, ��3��, �ֱ���2,2,3����Ԫ�ɶ���Ϊ[2,2,3]
num_input = size(X, 2);
num_output = size(y, 2);
hidden_num_list = [3, 3]; % ���޸����ز�Ĳ�����ÿ�����
% ��һ�������ʾ������Ľṹ
unit_num_list = [num_input, hidden_num_list, num_output];

% ѧϰ����
ALPHA = 0.1;

% ��������
ITERATION = 1000;

% ���Լ�����
test_ptage = 0.2;


%% ������ʼ��

% ��������
m = size(X, 1);
% ѵ��������
m_train = ceil(m * (1 - test_ptage));
% ���Լ�����
m_test = m - m_train;

% ��������˳��
sel = randperm(m);
X = X(sel,:); y = y(sel,:);

% ���ݱ������� ѵ���� �� ���Լ�
Xtrain = X(1:m_train, :); ytrain = y(1:m_train, :); 
Xtest = X(m_train+1:end, :); ytest = y(m_train+1:end, :);

% raw��1,2,3��ʾ, ������010, 100, 001
ytrain_raw = [];
for i = 1:m_train
    ytrain_raw = [ytrain_raw; find(ytrain(i, :), 1)];
end
ytest_raw = [];
for i = 1:m_test
    ytest_raw = [ytest_raw; find(ytest(i, :), 1)];
end

fprintf('������㼶�ṹ: (����� -> ���ز� -> �����)\n');
fprintf('%d', unit_num_list(1));
for i = 2:size(unit_num_list, 2)
    fprintf(' -> %d', unit_num_list(i));
end
fprintf('\n\n');

fprintf('��������: %d ��   ѧϰ����: %.4f\n\n', ITERATION, ALPHA);


%% ѵ��

fprintf('---- �� 2 �׶�: ѵ��ģ�� ----\n\n');

fprintf('<���������ʼѵ��>\n')

pause;

[WEIGHT THETA ERROR] = trainingNN(Xtrain, ytrain, unit_num_list, ALPHA, ITERATION);

% ������
fprintf('\n���: (ƽ����)\n%.5f (��1�ε���) -> %.5f (��%d�ε���)\n\n', sum(ERROR(1,:) .^ 2), sum(ERROR(end,:) .^ 2), ITERATION);

ERROR_X = 1:ITERATION;
ERROR_Y = sum(ERROR .^ 2, 2);

plot(ERROR_X, ERROR_Y, '-');
xlabel('��������');
ylabel('���');
title('������');

% ׼ȷ��

pred = predict(Xtrain, THETA, WEIGHT, unit_num_list);
pred_raw = zeros(size(pred,1), 1);  % raw��ָ��ǩ��1, 2, 3��ʾ, ������010, 100������
for i = 1:size(pred, 1)
    find(pred(i, :), 1);
    pred_raw(i, :) = find(pred(i, :), 1);
end

fprintf('ѵ����׼ȷ��: %f\n\n', mean(double(pred_raw == ytrain_raw)) * 100);


%% Ԥ��

fprintf('---- �� 3 �׶�: Ԥ�� ----\n\n');

fprintf('<���������ʼԤ��>\n')

pause;

pred = predict(Xtest, THETA, WEIGHT, unit_num_list);
pred_raw = zeros(size(pred,1), 1);  % raw��ָ��ǩ��1, 2, 3��ʾ, ������010, 100������
for i = 1:size(pred, 1)
    find(pred(i, :), 1);
    pred_raw(i, :) = find(pred(i, :), 1);
end

fprintf('���Լ�׼ȷ��: %f\n\n', mean(double(pred_raw == ytest_raw)) * 100);

























