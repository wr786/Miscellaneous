
for n = 0:13
    Fs1 = calc(n, 0);
    Fs2 = calc(n, 1.44);
    x = [0:0.01:1.44];
    maxy = zeros(145);  % store the maxvalue of Ys
    hold on;
    for i = 1: 24+4*n
        y = (Fs2(i) - Fs1(i)) .* x ./ 1.44 + Fs1(i);
        % plot(x, abs(y));
        maxy = max(maxy, y);
        maxy = max(maxy, -y); % abs
    end
    plot(x, maxy.');
end
    
function ret = calc(n, Q)

    sint = 3 / 5;
    cost = 4 / 5;
    sinp = (4-sqrt(3)) / sqrt(28 - 8*sqrt(3));
    cosp = 3 / sqrt(28 - 8*sqrt(3));
    sin30 = 1/2;
    cos30 = sqrt(3)/2;

    b = zeros(24+4*n, 1);    % n dim empty vector
    A = zeros(24+4*n, 24+4*n);    % a n*n empty matrix

    % fill b
    b(1:20) = [0; -1; -1; 0; 0; 0; Q; 0; 0; 0; Q; 0; 0; 0; Q-2; 0; 0; 0; Q; 0];
    for i = 1:n
        b(17 + 4*i: 20 + 4*i) = [0; 0; Q; 0];
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