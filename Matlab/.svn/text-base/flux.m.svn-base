function res=flux(first,last,loadResult);



pointsPerBox=8;
scale=0.05;

cellWidth=3;
minX=-10;
maxX=70;
minY=0;
maxY=60;
minZ=-90;
maxZ=-30;

if loadResult==0
        
    grid=zeros(floor((maxX-minX)/cellWidth+0.5)+1,...
               floor((maxY-minY)/cellWidth+0.5)+1,...
               floor((maxZ-minZ)/cellWidth+0.5)+1,4);
    
    size(grid)       
    
    for n=first:last
        n
        name='D:/aneurysm/inflow/trajPoint.';
        le=length(name);
        ext=int2str(n);
        nd=length(ext);
        for j=1:nd
            name(le+j)=ext(j);
        end
        f=load(name);
        si=size(f);
        if si(1,1)>0
            x=1000*f(:,1);
            y=1000*f(:,2);
            z=1000*f(:,3);
            u=2*f(:,4);
            v=2*f(:,5);
            w=2*f(:,6);
            age=f(:,29);
            
            begi=1;
            ende=1;
            for i=1:si(1,1)
                if x(i)>-minX & x(i)<maxX & y(i)>minY & y(i)<maxY & z(i)>minZ & z(i)<maxZ
                    
                    indX=floor((x(i)-minX)/cellWidth)+1; 
                    indY=floor((y(i)-minY)/cellWidth)+1;
                    indZ=floor((z(i)-minZ)/cellWidth)+1;
                    
                    %%[indX indY indZ]
                    
                    grid(indX,indY,indZ,1)=grid(indX,indY,indZ,1)+u(i);
                    grid(indX,indY,indZ,2)=grid(indX,indY,indZ,2)+v(i);
                    grid(indX,indY,indZ,3)=grid(indX,indY,indZ,3)+w(i);
                    grid(indX,indY,indZ,4)=grid(indX,indY,indZ,4)+1;
                end    
            end
        end
    end
    save result grid;
else
    load result;
    size(grid)
end

maxVel=0;
figure;
floor(0.5*(maxX-minX)/cellWidth+0.5)

throughFlux=0;

for indX=1:floor((maxX-minX)/cellWidth+0.5)+1
    for indY=1:floor((maxY-minY)/cellWidth+0.5)+1
        for indZ=1:floor((maxZ-minZ)/cellWidth+0.5)+1
            if grid(indX,indY,indZ,4)>pointsPerBox
                grid(indX,indY,indZ,1)=grid(indX,indY,indZ,1)/grid(indX,indY,indZ,4);
                grid(indX,indY,indZ,2)=grid(indX,indY,indZ,2)/grid(indX,indY,indZ,4);
                grid(indX,indY,indZ,3)=grid(indX,indY,indZ,3)/grid(indX,indY,indZ,4);
                quiver3(indX*cellWidth+minX-0.5*cellWidth,...
                        indY*cellWidth+minY-0.5*cellWidth,...
                        indZ*cellWidth+minZ-0.5*cellWidth,...
                        grid(indX,indY,indZ,1),grid(indX,indY,indZ,2),grid(indX,indY,indZ,3),...
                        scale,'b');
               hold on;
               if indX=floor(0.5*(maxX-minX)/cellWidth+0.5)
                   throughFlux=throughFlux+grid(indX,indY,indZ,1)*(cellWidth*0.001)^2;
               end
                %%statistics
                vel=(grid(indX,indY,indZ,1)^2+grid(indX,indY,indZ,1)^2+grid(indX,indY,indZ,1)^2)^0.5;
                if vel>maxVel
                    maxVel=vel;
                end
                %%end statistics
            end
        end
    end
end

maxVel=maxVel

xlabel('x (mm)','FontSize',22)
ylabel('y (mm)','FontSize',22)
zlabel('z (mm)','FontSize',22)


throughFlux=throughFlux*1000*60