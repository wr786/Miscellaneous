%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%参数区%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 用于确定总共的n的数量（原题目中对应的情况为nMin = nMax = 0）
nMin = 6;
nMax = 6;  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%main%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 计算各个Q(单位P)下，当时所有的杆受到的最大的压力
for n = nMin:nMax
    Fs1 = calc(n, 0);
    Fs2 = calc(n, 0.06);
    x = (0:0.0001:0.06);
    ys = zeros(24 + 4*n, 601);
    maxy = zeros(1, 601);  % store the maxvalue of Ys
    mark = zeros(1, 601);
    marked = zeros(1, 24+4*n);
    for i = 1: 24+4*n
        y = -((Fs2(i) - Fs1(i)) .* x ./ 0.06 + Fs1(i)); % 修正为向内取正（只考虑受压力的最大值）
        ys(i, :) = y;
        if i <= 21 + 4*n
            maxy = max(maxy, y);
        end
        % disp(maxy);
        for j = 1:601
            if maxy(j) == y(j)
               if i <= 21 + 4*n
                    mark(j) = i;
               end
            end
        end
        % maxy = max(maxy, -y); % abs
    end
end

if nMin == nMax
    % 绘制危险杆件压力随均布荷载q增大（0P/m~0.06P/m）的变化曲线
    % showDangerousLanes(mark, marked, x, ys);
    % 绘制折线图
    sep_plot(mark, x, maxy);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%函数区%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 计算在不同n、Q下，各个杆的受力
function ret = calc(n, q)
    Q = 15 * q;

    sint = 3 / 5;
    cost = 4 / 5;
    sinp = (4-sqrt(3)) / sqrt(28 - 8*sqrt(3));
    cosp = 3 / sqrt(28 - 8*sqrt(3));
    sin30 = 1/2;
    cos30 = sqrt(3)/2;

    b = zeros(24+4*n, 1);    % n dim empty vector
    A = zeros(24+4*n, 24+4*n);    % a n*n empty matrix

    % fill b
    b(1:20) = [0; -1; -1; 0; 0; 0; Q; 0; 0; 0; 2*Q; 0; 0; 0; 2*Q-2; 0; 0; 0; 2*Q; 0];
    for i = 1:n
        b(17 + 4*i: 20 + 4*i) = [0; 0; 2*Q; 0];
    end
    b(21 + 4*n: 24 + 4*n) = [0; 0; Q; 0];
    % disp(b);

    % fill A
    A(1:16, 1:16) = [
        1	-sin30	sinp	0	0	0	0	0	0	0	0	0	0	0	0	0;
        0	cos30	cosp	0	0	0	0	0	0	0	0	0	0	0	0	0;
        1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
        0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0;
        0	sin30	0	0	1	0	0	0	0	0	0	0	0	0	0	0;
        0	cos30	0	0	0	-1	0	0	0	0	0	0	0	0	0	0;
        0	0	sinp	0	1	0	cost	0	0	0	0	0	0	0	0	0;
        0	0	cosp	1	0	0	-sint	-1	0	0	0	0	0	0	0	0;
        0	0	0	0	0	0	cost	0	1	0	cost	0	0	0	0	0;
        0	0	0	0	0	1	sint	0	0	-1	-sint	0	0	0	0	0;
        0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0;
        0	0	0	0	0	0	0	1	0	0	0	-1	0	0	0	0;
        0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0;
        0	0	0	0	0	0	0	0	0	1	0	0	0	-1	0	0;
        0	0	0	0	0	0	0	0	0	0	cost	0	1	0	cost	0;
        0	0	0	0	0	0	0	0	0	0	sint	1	0	0	-sint	-1
    ];
    for i = 0:n
        A(17+4*i: 20+4*i, 14+4*i: 20+4*i) = [
            0	cost	0	1	0	0	0;
            1	sint	0	0	-1	0	0;
            0	0	0	1	0	cost	0;
            0	0	-1	0	0	sint	1
        ];
    end
    A(21+4*n: 24+4*n, 18+4*n: 24+4*n) = [
        0	cost	0	1	0	0	0;
        1	sint	0	0	-1	0	0;
        0	0	0	1	0	1	0;
        0	0	1	0	0	0	-1;
    ];
    ret = A\b;
    
end

% 用于显示各Q(单位P)下，当时受压力最大的杆的序号
% 建议只在nMin == nMax时使用
function sep_plot(mark, x, maxy)
    figure;
    hold on;
    lines = zeros(1, 601);
    leftBound = 1;
    rightBound = 1;
    curColor = mark(1);
    colorCnt = 1;
    lines(colorCnt) = mark(1);
    % disp(mark);
    for j = 2:601
        if curColor == mark(j)
            rightBound = rightBound + 1;
        else
            plot(x(leftBound: rightBound), maxy(leftBound: rightBound));
            rightBound = rightBound + 1;
            leftBound = rightBound;
            curColor = mark(j);
            colorCnt = colorCnt + 1;
            lines(colorCnt) = mark(j);
        end
    end
    % plot(x, maxy.');
    plot(x(leftBound: rightBound), maxy(leftBound: rightBound).')
    % legend("F" + (0: nMax));
    legend("杆"  + lines(1: colorCnt));
    xlabel("q(/P)");
    ylabel("F(/P)");
    hold off;
end

% 用于绘制危险杆件压力随均布荷载q增大（0P/m~0.06P/m）的变化曲线
% 建议只在nMin == nMax时使用
function showDangerousLanes(mark, marked, x, ys)
    for j = 1:601
        if marked(mark(j)) == 0
            marked(mark(j)) = 1;
            figure;
            plot(x, ys(mark(j),:));
            xlabel("q(/P)");
            ylabel("F(/P)");
            legend("杆" + mark(j));
        end
    end
end