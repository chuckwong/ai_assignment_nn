%% ��һ��
function [X_norm, maxVal, minVal] = featureNormalize(X)

X_norm = X;

maxVal = max(X);
minVal = min(X);

% ��������
m = size(X_norm, 1);

% ���ɶ���һ����max��min
maxVal = repmat(maxVal, m, 1);
minVal = repmat(minVal, m, 1);


X_norm = (X_norm - minVal) ./ (maxVal - minVal);


end
