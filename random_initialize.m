%% �����ʼ����������, size�Ƿ��صĳߴ�, F�������ĵ�Ԫ����
function R = random_initialize(size, F)

R = rand(size(1), size(2)); % ��ʼ��0 - 1
R = R .* 2 - 1;             % ��Χ�任��-1 - 1
R = (2.4 / F) .* R;         % Haykin�Ĺ�ʽ

end