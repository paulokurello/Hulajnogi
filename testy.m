clear all; close all; 
clf;

%dane: 1 - test poprawności, 2 - zlozony, 3 - Ochota
dane = 3;
if dane == 3
    L_wsp = [52.212509793024886	20.95412108828744;
    52.20798717932157	20.96427507719185;
    52.212691257290345	20.96211726411706;
    52.20990709202495	20.98361414727443;
    52.20623210642204	20.981055392724723;
    52.20325398954929	20.97211985640407;
    52.21193181684882	20.982230645763376;
    52.218051699241045	20.984209475487855;
    52.22152276523247	20.98612135613357;
    52.224220396265466	20.98879698378162;
    52.22411433703207	20.99399608364281;
    52.21740721186681	20.99590802897172;
    52.21114586052559	20.989213755469855;
    52.216711418622886	20.98813297426602;
    52.204050473036006	20.977228958669155;
    52.19561008790273	20.97661556740549;
    52.198703103219586	20.977995875045487;
    52.20237469905069	20.95464549613488;
    52.21251700159822	20.97197154194268;
    52.21461907624597	20.96843812043275];

    nazwa = ["Blue City", "Pętla Szczęśliwicka", "Stacja Grawitacja", "Banacha Szpital", "WUM", "SP264", "MIM UW", "Dom Studencki Akademik", "Klub Dekada", "Raddison Blue Sobieski", "PJTK", "VII LO", "Jeffs", "Pomnik Lotnika", "Plac Zabaw Wiślicka", "Kościół Zwiastowania Pańskiego", "Auchan Supermarket", "Rynek Włodarzy", "PZPN", "Ibis Reduta"];

end
if dane == 2
    L_wsp = [10 18;
             -18 17;
             17 10;
             -6 6;
             5 4;
             15 -2;
             3 -6;
             -10 10;
             10 -11;
             16 -18];
end
if dane == 1
    L_wsp = [0 0;
             4 0;
             0 3;
             -5 0;
             0 -4];
end
n=size(L_wsp,1); % liczba punktów zapotrzebowania

L=containers.Map();
for i=1:n    
    L(string(i))=[L_wsp(i,1),L_wsp(i,2)];
    if dane ~= 3
        nazwa(i)='Location '+string(i);
    end
end
f = @(x,y) sqrt((y(1)-x(1))^2+(y(2)-x(2))^2);

O=zeros(n,n);

% Obliczanie odległości
for i=1:n
    for j=1:n
        if dane == 3
            O(i,j)=f(L(string(i)),L(string(j)))*111111; % 111111 bo w metrach
        else
            O(i,j)=f(L(string(i)),L(string(j)));
        end
    end
end

% Rysowanie na wykresie
hold on; grid on;
%zakresy i nazwy osi
if dane ~= 3
    axis([min(L_wsp(:,1))-1 max(L_wsp(:,1))+1 min(L_wsp(:,2))-1 max(L_wsp(:,2))+1]);
    xlabel('x');
    ylabel('y');
else
    axis([52.19 52.23 20.95 21]);
    xlabel('Długość geograficzna [^o]');
    ylabel('Szerokość geograficzna [^o]');
end

prescaler=50; % do umieszczenia napisów na wykresie
for i=1:n
    plot(L_wsp(i,1),L_wsp(i,2),'or', 'MarkerSize',10);
    
    %napisy
    if dane ~= 3
        text(L_wsp(i,1)+(max(L_wsp(:,1))-(min(L_wsp(:,1))))/prescaler,L_wsp(i,2)+(max(L_wsp(:,2))-(min(L_wsp(:,2))))/prescaler,nazwa(i));
    else
        text(L_wsp(i,1)+0.0001,L_wsp(i,2)+0.001, nazwa(i));
    end
end