%% ����� 2014101027 ��������ҵ

clear;
clc;

%% �������ݺͲ��ֲ���

fprintf('---- �� 1 �׶�: �������� ----\n\n');

% ��������
[X, y, y_raw, labels] = loadData('iris.txt', ' ');

% �������, ��3��, �ֱ���2,2,3����Ԫ�ɶ���Ϊ[2,2,3]
num_input = size(X, 2);
num_output = size(y, 2);
hidden_num_list = [3, 2]; % ���޸����ز�Ĳ�����ÿ�����
unit_num_list = [num_input, hidden_num_list, num_output];

% ѧϰ����
ALPHA = 0.1;

% ��������
ITERATION = 200;

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

fprintf('������㼶�ṹ:(����� -> ���ز� -> �����)\n');
fprintf('%d', unit_num_list(1));
for i = 2:size(unit_num_list, 2)
    fprintf(' -> %d', unit_num_list(i));
end
fprintf('\n\n');

fprintf('��������: %d   ѧϰ����: %.4f\n\n', ITERATION, ALPHA);


%% ѵ��

fprintf('---- �� 2 �׶�: ѵ��ģ�� ----\n\n');

fprintf('<���������ʼѵ��>\n')

pause;

[THETA WEIGHT ERROR] = trainingNN(Xtrain, ytrain, unit_num_list, ALPHA, ITERATION);

% ������
fprintf('\n���:\n%.5f (��1�ε���) -> %.5f (��%d�ε���)\n\n', sum(ERROR(1,:) .^ 2), sum(ERROR(end,:) .^ 2), ITERATION);


% ׼ȷ��
ERROR_X = 1:ITERATION;
ERROR_Y = sum(ERROR .^ 2, 2);

plot(ERROR_X, ERROR_Y, '-');
xlabel('��������');
ylabel('���');
title('������');

%% Ԥ��

























