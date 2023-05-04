import net.sf.javabdd.BDDFactory
BDD=BDDFactory.init(100, 100);
BDD.setVarNum(100);
g=Gtestkuo();
G=Network(g,-1,1);
bddG = Decompose(G,BDD);
bddG.printDot();
Reliability(bddG)
bddG = Composition(G,BDD,bddG);
bddG.printDot();
Reliability(bddG)


function bddG =Composition(G,BDD,bddG)
    for e =G.eList
        %e2和e3是e上联通的两个端，e1是e的id
        bdde=BDD.ithVar(e(1));
        bddv1=BDD.ithVar(e(2));
        bddv2=BDD.ithVar(e(3));
        bddPairing = BDD.makePair(e(1),bddv1.and(bdde.and(bddv2)));
        bddG=bddG.veccompose(bddPairing);
    end
end

function bdd = Decompose(G,BDD)
    s = G.v_S;
    if(s==G.v_T)
        bdd=BDD.one;
        return;
    end
    bddr=BDD.zero();
    for e =G.eList
        %e2和e3是e上联通的两个端，e1是e的id
        if (G.v_S==e(2))
            bdde=BDD.ithVar(e(1));
            G2=Network(G,e(2),e(3));
            bddG2=Decompose(G2,BDD);
            bddG2=bddG2.and(bdde);
            bddr=bddr.or(bddG2);
            continue;  
        end
        if (G.v_S==e(3))
            bdde=BDD.ithVar(e(1));
            G2=Network(G,e(3),e(2));
            bddG2=Decompose(G2,BDD);
            bddG2=bddG2.and(bdde);
            bddr=bddr.or(bddG2);
            continue;
        end 
    end
    bdd=bddr;
end
function r=Reliability(bddG)
    if(bddG.isOne())
        r=1.0;
        return;
    end
    if(bddG.isZero())
        r=0.0;
        return;
    end
    r=0.9*Reliability(bddG.high())+0.1*Reliability(bddG.low());
    return
end

    

