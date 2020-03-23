%all gui game message in one place
global message simulation

if(simulation.language==1)
    message.title = "Educational package for visualizing the basic electromagnetic phenomena";
    message.buttonReset = "Reset";
    message.buttonNewGame = "New Game";
    message.buttonSimulation = "Simulation";
    message.buttonMenuLevel = "level                      number of attempts";
    
    message.textHeadingInit = sprintf('To start the game, select a level and press the New Game button');
    message.textHeadingStart = sprintf('The grey path shows the approximate trajectory the released charge was moving on during a random simulation. Move the charges or wires that are on the area so that the charges move track will fit with the path. Then press the Simulation button to verify the result.');
    message.textHeadingMove = sprintf('The charge has released and set off :)');
    message.textHeadingWin = sprintf('Congratulations, you win and correctly estimate the simulations! Now you can go to the next level or play again to consolidate your knowledge.');
    message.textHeadingLose = sprintf('Unfortunately, you did not manage to reconstruct the simulation correctly! Analyse the shown trajectory the positron was moving on. Correct the position electric charge or conductors and try again.');
    message.textHeadingError= sprintf('Something was wrong, select a level and press the New Game button again.');
    message.textHeadingWait= sprintf('The calculations are in progress - please wait.');
    
    
    message.textLeftInit = sprintf('-the area has the dimensions           1 [m] x 1 [m] on which move the POSITRON\n\n-initial velocity:\n   Vo = 100 [m/s]\n-mass:\n   m = 9,1*10^-31 [kg]  \n-electric charge:\n   e+ = 1,6*10^-19 [C]');
    message.textLeft{1} = sprintf('                   LEVEL1\n\n-there is only one charge on the board\n\n         q = +e, -e\n\n-charge radius equal\n\n        R = 0.01 [m]\n\n                 REMEBER\n\n-the charges can not crash with each other');
    message.textLeft{2} = sprintf('                   LEVEL2\n-there are two charges (bigger and smaller) on the board\n\n         q = +e, -e\n-charges radii equal\n    R = 0.01 [m], R = 0.02 [m]\n                REMEBER\n-the charges can not crash with each other');
    message.textLeft{3} = sprintf('                   LEVEL3\n-there is one wire on the board\n-amperage \n      I = 1[mA]\n\n                 REMEBER\n\n-remember that a moving charge cannot crash the wire\n\n-the current always flows from plus to minus');
    message.textLeft{4} = sprintf('                   LEVEL4\n\n-there is one wire and one charge the board\n\n-charge radius and amperage\n q = +e, -e, R = 0.01 [m],  I = 1 [mA]   \n                 REMEBER\n\n-the charges can not crash with each other\n\n-that a moving charge cannot crash the wire\n\n-the current always flows from plus to minus\n');
    message.textLeft{5} = sprintf('                   LEVEL5\n-there is two wire and two charges (bigger and smaller) the board\n-charges radii and amperage\n q = +e, -e,  I = 1 [mA]\n R = 0.01 [m], R = 0.02 [m]\n                 REMEBER\n-the charges can not crash with each other\n-that a moving charge cannot crash the wire\n-the current always flows from plus to minus');
    
else
    message.title = "Pakiet edukacyjny wizualizuj�cy podstawowe zjawiska elektromagnetyczne";
    message.buttonReset = "Reset";
    message.buttonNewGame = "Nowa Gra";
    message.buttonSimulation = "Symulacja";
    message.buttonMenuLevel = "poziom                            liczba pr�b";
    
    message.textHeadingInit = sprintf('Aby rozpocz�� gr� wybierz poziom i naci�nij przycisk Nowa Gra');
    message.textHeadingStart = sprintf('Na szaro wida� przybli�on� tras� po kt�rej porusza� si� wypuszczony �adunek podczas losowej symulacji. Przestaw �adunki lub przewody, kt�ry znajduj� si� na planszy tak, aby tor ruchu �adunku si� pokrywa� ze �cie�k� poruszaj�cego si� �adunku. Nast�pnie naci�nij przycisk Symulacja w celu weryfikacji wyniku.');
    message.textHeadingMove = sprintf('�adunek wystartowa� w drog� :)');
    message.textHeadingWin = sprintf('Gratulacje uda�o Ci si� poprawnie odwzorowa� symulacje! Teraz mo�esz przej�� do nast�pnego poziomu lub zagra� jeszcze raz w celu utrwalenia wiedzy.');
    message.textHeadingLose = sprintf('Niestety nie uda�o Ci si� poprawnie odwzorowa� symulacji! Przeanalizuj pokazana tras� po jakiej porusza� si� �adunek. Popraw po�o�enia i spr�buj jeszcze raz.');
    message.textHeadingError= sprintf('Co� posz�o nie tak, wybierz poziom i naci�nij przycisk Nowa Gra jeszcze raz.');
    message.textHeadingWait= sprintf('Trwaj� obliczenia - prosz� czeka�.');
    
    message.textLeftInit = sprintf('-plansza ma wymiary 1 [m] x 1 [m] do kt�rej wpuszczamy POZYTON\n\n-pr�dko�� pocz�tkowa:\n   Vo = 100 [m/s]\n-masa:\n   m = 9,1*10^-31 [kg]  \n-�adunek:\n   e+ = 1,6*10^-19 [C]');
    message.textLeft{1} = sprintf('                   POZIOM 1\n\n-na planszy jest tylko jeden �adunek o warto�ci\n\n         q = +e, -e\n\n-promie� �adunku wynosi\n        R = 0.01 [m]\n\n                 PAMI�TAJ\n-�adunki nie mog� si� ze sob� zderzy�');
    message.textLeft{2} = sprintf('                   POZIOM 2\n-na planszy s� dwa �adunki (wi�kszy i mniejszy) o warto�ci\n\n         q= +e, -e\n-promienie ��dunk�w wynosz�\n    R = 0.01 [m], R = 0.02 [m]\n                 PAMI�TAJ\n-�adunki nie mog� si� ze sob� zderzy�');
    message.textLeft{3} = sprintf('                   POZIOM 3\n-na planszy jest jeden przewodnik\n-nat�enie pr�du\n     I = 1[mA]\n\n                 PAMI�TAJ\n\n-lec�cy �adunek nie mo�ne przeci�� przewodu\n\n-pr�d p�ynie zawsze w kierunku od plusa do minusa');
    message.textLeft{4} = sprintf('                   POZIOM 4\n-na planszy jest �adunek, a tak�e przewodnik\n\n-promie� �adunku oraz nat�enie pr�du\n\n q = +e, -e, R = 0.01 [m],  I = 1 [mA]  \n                 PAMI�TAJ\n-�adunki nie mog� si� ze sob� zderzy�\n\n-lec�cy �adunek nie mo�ne przeci�� przewodu\n\n-pr�d p�ynie zawsze w kierunku od plusa do minusa');
    message.textLeft{5} = sprintf('                   POZIOM 5\n-na planszy s� dwa �adunki  (wi�kszy i mniejszy), a tak�e dwa przewodniki\n-promienie �adunk�w oraz nat�enie pr�du\n q = +e, -e,  I = 1 [mA]\n R = 0.01 [m], R = 0.02 [m]\n                 PAMI�TAJ\n-�adunki nie mog� si� ze sob� zderzy�\n-lec�cy �adunek nie mo�ne przeci�� przewodu\n-pr�d p�ynie zawsze w kierunku od plusa do minusa');
end