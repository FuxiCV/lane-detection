clc;clear all;close all
s=600;
V=mmreader('F1.wmv');
Is=read(V,[1 s]);
r=240;c=320;
r1=round(r*0.4);r2=round(r*0.94);
ch=160;
ri=r2-r1;
for i=1:2:s
    tic
    C=Is(:,:,:,i);
    CI=C(r1:r2,:,:);%划分%划分
    G=rgb2gray(CI);%变灰
    %%寻找阈值
    g=G(:);
    mu=mean(g);
    g=single(g);sige=std(g);%标准差
    %阈值
    T=mu+3*sige;
    %模板B
    B=G>T;    
    t=0;
    for u=1:ri
        for v=ch:-1:1
            if B(u,v)
                t=t+1;
                Y1(t)=u+r1;
                X1(t)=v;
                break
            end
        end
    end
    t=0;
    for u=1:ri
        for v=ch:c
            if B(u,v)
                t=t+1;
                Y2(t)=u+r1;
                X2(t)=v;
                break
            end
        end
    end
    p1=polyfit(X1,Y1,1);p2=polyfit(X2,Y2,1);
    x1=1:10:ch;x2=ch:10:c;
    F1=x1.*p1(1)+p1(2);
    F2=x2.*p2(1)+p2(2);
    toc
    figure(1),imshow(C),hold on
    plot(x1',F1,'g',x2',F2,'g','LineWidth',2)
    title(i)
    hold off
    mov(i)=getframe(gca);
end
movie2avi(mov,'F1处理后');