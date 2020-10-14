% 定义各边长数据
BC = 1.650;
BD = 8.336;
DE = 1.316;
AE = 6.733;
AF = 0.818;
FC = 2.520;
EG = 5.500;
phi = 0.30979595173611113;  % 17.75°
DG = EG - DE;   % 4.184
B = [-1.140, -1.540];
A = [0.230, 2.050];
X = 1:0.1:1.8;

% =======================第一小题代码=========================
% 解方程并赋值
% syms t1 t2 t3 t4
% x = 1.433;   % 第一题，同时也是用来验证程序正确性
% eqn1 = (x*cos(t1) - BC*cos(t2-phi) == B(1));
% eqn2 = (x*sin(t1) - BC*sin(t2-phi) == B(2));
% S1 = solve([eqn1, eqn2], [t1, t2]);
% T1 = S1.t1(2);  % 选择正值，舍弃负值
% T2 = S1.t2(2);
% eqn3 = (x*cos(T1) - BC*cos(T2-phi) + BD*cos(T2) + DE*cos(t3) - AE*cos(t4) == A(1));
% eqn4 = (x*sin(T1) - BC*sin(T2-phi) + BD*sin(T2) + DE*sin(t3) - AE*sin(t4) == A(2));
% S2 = solve([eqn3, eqn4], [t3, t4]);
% T3 = S2.t3(1);  % 这里(2)才是负值，所以选择正值(1)
% T4 = S2.t4(2);
% posX = eval(x*cos(T1) - BC*cos(T2-phi) + BD*cos(T2) - DG*cos(T3));
% posY = eval(x*sin(T1) - BC*sin(T2-phi) + BD*sin(T2) - DG*sin(T3));
% disp(posX);
% disp(posY);

% =======================第二小题代码=========================
% 解方程并赋值并画图
syms t1 t2 t3 t4
for i = 1:9
    disp(i);    % 显示运算进度
	eqn1 = (X(i)*cos(t1) - BC*cos(t2-phi) == B(1));
	eqn2 = (X(i)*sin(t1) - BC*sin(t2-phi) == B(2));
	S1 = solve([eqn1, eqn2], [t1, t2]);
	T1 = S1.t1(2);  % 选择正值，舍弃负值
	T2 = S1.t2(2);
	eqn3 = (X(i)*cos(T1) - BC*cos(T2-phi) + BD*cos(T2) + DE*cos(t3) - AE*cos(t4) == A(1));
	eqn4 = (X(i)*sin(T1) - BC*sin(T2-phi) + BD*sin(T2) + DE*sin(t3) - AE*sin(t4) == A(2));
	S2 = solve([eqn3, eqn4], [t3, t4]);
	T3 = S2.t3(1);  % 这里(2)才是负值，所以选择正值(1)
	T4 = S2.t4(2);
	posX(i) = eval(X(i)*cos(T1) - BC*cos(T2-phi) + BD*cos(T2) - DG*cos(T3));
	posY(i) = eval(X(i)*sin(T1) - BC*sin(T2-phi) + BD*sin(T2) - DG*sin(T3));
end

plot(posX, posY, 'm');
xlabel('x');
ylabel('y');
title('Plot of Point G','FontSize',12);
axis equal;