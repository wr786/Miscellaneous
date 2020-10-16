% 定义各题给数据
B = [-1.14, -1.54];
A = [0.23, 2.05];
OB = len(B);
OA = len(A);
vBA = A - B;    % 向量BA
BA = len(vBA);
% OC = 1.433;
OC = linspace(1.0, 1.8, 9);   % vector
BC = 1.65;
BD = 8.336;
DE = 1.316;
AE = 6.733;
AF = 0.818;
FC = 2.52;
EG = 5.5;
DG = 4.184;
PHI = 0.30979595173611113;  % 17.75°懒得用sind、cosd之类的

% 计算θ2
th2 = atan(B(2)/B(1)) + acos((BC^2 + OB^2 - OC.^2)/(2*BC*OB));
% disp(atan(B(2)/B(1)));
% disp(th2);

% 计算θ4
phi = atan((vBA(1) - BD*cos(th2+PHI))./(vBA(2) - BD*sin(th2+PHI)));
% disp(phi);
th4 = asin(-((BD^2 + DE^2 + BA^2 - AE^2 - 2*BD*vBA(1)*cos(th2+PHI) - 2*BD*vBA(2)*sin(th2+PHI)) / 2 / DE ./sqrt(BA^2 + BD^2 - 2*vBA(1)*BD*cos(th2+PHI) - 2*vBA(2)*BD*sin(th2+PHI)))) - phi;
% disp(th4);

% 计算G点坐标
X = B(1) + BD*cos(th2+PHI) - DG*cos(th4);
Y = B(2) + BD*sin(th2+PHI) - DG*sin(th4);
% disp(X);
% disp(Y);
plot(X, Y, 'm');
xlabel('x');
ylabel('y');
title('Plot of Point G','FontSize',12);
axis equal;

% 创建函数方便计算
function l = len(Point)
    l = sqrt(Point(1) ^ 2 + Point(2) ^ 2);
end