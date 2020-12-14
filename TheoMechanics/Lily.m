sint = 3 / 5;
cost = 4 / 5;
sinp = (4-sqrt(3)) / sqrt(28 - 8*sqrt(3));
cosp = 3 / sqrt(28 - 8*sqrt(3));

% Ax = b %
% unit: P %
syms Q;
b = [0; -1; -1; 0; 0; 0; Q; 0; 0; 0; Q; 0; 0; 0; Q-2; 0; 0; 0; Q; 0; 0; 0; Q; 0];
A = [
    1	-1/2	sinp	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
    0	sqrt(3)/2	cosp	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
    1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
    0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
    0	1/2	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
    0	sqrt(3)/2	0	0	0	-1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
    0	0	sinp	0	1	0	cost	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
    0	0	cosp	1	0	0	-sint	-1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
    0	0	0	0	0	0	cost	0	1	0	cost	0	0	0	0	0	0	0	0	0	0	0	0	0;
    0	0	0	0	0	1	sint	0	0	-1	-sint	0	0	0	0	0	0	0	0	0	0	0	0	0;
    0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
    0	0	0	0	0	0	0	1	0	0	0	-1	0	0	0	0	0	0	0	0	0	0	0	0;
    0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0;
    0	0	0	0	0	0	0	0	0	1	0	0	0	-1	0	0	0	0	0	0	0	0	0	0;
    0	0	0	0	0	0	0	0	0	0	cost	0	1	0	cost	0	0	0	0	0	0	0	0	0;
    0	0	0	0	0	0	0	0	0	0	sint	1	0	0	-sint	-1	0	0	0	0	0	0	0	0;
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	cost	0	1	0	0	0	0	0	0	0;
    0	0	0	0	0	0	0	0	0	0	0	0	0	1	sint	0	0	-1	0	0	0	0	0	0;
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	cost	0	0	0	0	0;
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-1	0	0	sint	1	0	0	0	0;
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	cost	0	1	0	0	0;
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	sint	0	0	-1	0	0;
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	1	0;
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	-1
];

Fs = A\b;

Fs1 = eval(subs(Fs, Q, 0));    % condition of Q == 0
Fs2 = eval(subs(Fs, Q, 1.44)); % condition of Q == 1.44P
% Fs3 = eval(subs(Fs, Q, 1));    % condition of Q == 1P
% Fs4 = eval(subs(Fs, Q, 0.5));    % condition of Q == 0.5P

% 绘制柱形图
bars = bar([Fs1 Fs2]);
grid on;
children = get(bars, 'children');
set(gca,'XLim', [1 24]);
set(gca, 'XTickLabel', {'F1','F2','F3','F4','F5','F6','F7','F8','F9','F10','F11','F12','F13','F14','F15','F16','F17','F18','F19','F20','F21','FB','FAX','FAY'});
legend('Q = 0P', 'Q = 1.44P');
ylabel('(P)');
set(gca,'XAxisLocation','origin','ticklabelinterpreter','latex','tickdir','out');

figure;
hold on;
xQ = [0 1.44];
% xQ = [0 0.5 1 1.44];
for i = 1:24
    % subplot(6, 4, i);
    % plot(xQ, [abs(Fs1(i)), abs(Fs4(i)), abs(Fs3(i)), abs(Fs2(i))]);
    % plot(xQ, [(Fs1(i)), (Fs4(i)),(Fs3(i)), (Fs2(i))]);
    
    % temply do the abs()
    % todo: use function to replace this
    if Fs1(i) * Fs2(i) < 0
        zeroPoint = -xQ(2) * Fs1(i) / (Fs2(i) - Fs1(i));
        plot([xQ(1) zeroPoint xQ(2)], [abs(Fs1(i)), 0, abs(Fs2(i))]);
    else
        plot(xQ, [abs(Fs1(i)), abs(Fs2(i))]);
    end
    
    % legend(string([1:24]));
end