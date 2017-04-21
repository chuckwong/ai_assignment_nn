%% ��ȡ�ı�
% splitChar��ÿ�еķָ��ַ�
% X��������, y�Ǳ�ǩ��, y_unit����Ӧ����������ĸ�ʽ, labels�Ǳ�ǩ����
% ������1 2 3 yes
%      2 3 4 no
%      1 3 5 yes
% y = [1 0; 0 1; 1 0]
% y_raw = [1; 2; 1] (ע���Ǵ�1��ʼ)  
% labels = {'yes', 'no'}
function [X, y, y_raw, labels] = loadData(fileName, splitChar)

fid = fopen(fileName);

X = [];
y = [];
y_raw = [];
labels = {};

while ~feof(fid)
    % X
    line=fgetl(fid);
    result = regexp(line, splitChar, 'split');
    temp = [];
    for i=1:size(result, 2) - 1 % ȥ����ǩ��
        temp = [temp str2num(cell2mat(result(i)))];
    end
    X = [X; temp];
    
    % label
    labelStr = result(end);
    if sum(ismember(labels, labelStr)) == 0
        % ���ڼ�����
        labels = [labels labelStr];
    end
    
    y_raw = [y_raw; find(ismember(labels, labelStr), 1)];
    
end;


for i=1:size(y_raw, 1)
    y = [y; ismember(labels, labels{y_raw(i)})];
end


% displaying

fprintf('������: %d ��\n������: %d ��\n���: ', size(X, 1), size(X, 2));

for i=1:size(labels, 2)
    fprintf('%s', labels{i});
    if i ~= size(labels, 2)
        fprintf(', ');
    end
end
fprintf('\n\n');

end