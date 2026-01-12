V = [1 1 0; 1 0 1; 0 1 1];
n = size(V,2);
U = zeros(size(V)); E = U;

U(:,1) = V(:,1); 
E(:,1) = U(:,1)/norm(U(:,1));

for i = 2:n
    U(:,i) = V(:,i);
    for j = 1:i-1
        U(:,i) = U(:,i) - dot(V(:,i),E(:,j))*E(:,j);
    end
    E(:,i) = U(:,i)/norm(U(:,i));
end

figure; hold on; grid on; axis equal; view(3);
c = 'rgb';

for i = 1:n
    quiver3(0,0,0,V(1,i),V(2,i),V(3,i),c(i),'LineWidth',2);
    quiver3(.05,.05,.05,U(1,i),U(2,i),U(3,i),[c(i),'-.'],'LineWidth',2);
    quiver3(.1,.1,.1,E(1,i),E(2,i),E(3,i),[c(i),'--'],'LineWidth',2);
end

legend('V1','V2','V3','U1','U2','U3','E1','E2','E3');
xlabel X; ylabel Y; zlabel Z;
title('Gram–Schmidt Orthonormalization');
hold off;
