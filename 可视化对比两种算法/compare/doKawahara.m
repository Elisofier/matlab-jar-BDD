function doKawahara(G,X)
    import net.sf.javabdd.BDDFactory
    BDD=BDDFactory.init(100, 100);
    BDD.setVarNum(100);
    bdd=MakeBDD(G,BDD);
    bdd=InsertVAll(bdd,X,G,BDD);
end
        function bdd = MakeBDD(G,BDD)
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
                    bddG2=MakeBDD(G2,BDD);
                    bddG2=bddG2.and(bdde);
                    bddr=bddr.or(bddG2);
                    continue;  
                end
                if (G.v_S==e(3))
                    bdde=BDD.ithVar(e(1));
                    G2=Network(G,e(3),e(2));
                    bddG2=MakeBDD(G2,BDD);
                    bddG2=bddG2.and(bdde);
                    bddr=bddr.or(bddG2);
                    continue;
                end 
            end
            bdd=bddr;
        end
        function bddH =InsertVAll(bdd,X,G,BDD)
            if(bdd.isOne())
                bddH=BDD.one;
                return;
            end
            if(bdd.isZero())
                bddH=BDD.zero;
                return;
            end
            r=bdd;
            z=X(1);
            if(length(X(:))==1)
                bddH=BDD.ithVar(X(1));
                return;
            end
            if(z==r.var())
                v1=bdd.high();
                v0=bdd.low();
                X(1)=[];
                H1=InsertVAll(v1,X,G,BDD);
                H0=InsertVAll(v0,X,G,BDD);
            end
            if(z~=r.var())
                X(1)=[];
                H1=InsertVAll(r,X,G,BDD);
                H0=Restrict0All(H1,z,G,BDD); 
            end
            bddH=BDD.ithVar(z).and(H1).or(H0);
        end

        function bdd=Restrict0All(H1,z,G,BDD)
            for e =G.eList
                %e2和e3是e上联通的两个端，e1是e的id
                if (z==e(2)||z==e(3))
                    H1.restrict(BDD.ithVar(e(1)));
                end
            end
            bdd=H1;
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
