***********  Mass Matrix
%     for mj=1:3
%         for mi=1:3
%             if mi==mj && mi==1
%                 
%                 g = @(xhat,yhat) xhat*xhat;
%             elseif mi==mj && mi==2
%                  
%                 g = @(xhat,yhat) yhat*yhat;
%             elseif mi==mj && mi==3
%                 
%                 g = @(xhat,yhat) (1-xhat-yhat)*(1-xhat-yhat);
%             elseif (mj==mi+1 && mj==2 )|| (mj==mi-1 && mj==1)
%                
%                 g = @(xhat,yhat) (yhat)*(xhat);
%             elseif (mj==mi+1 && mj==3 )|| (mj==mi-1 && mj==2)
%                 
%                 g = @(xhat,yhat) (1-xhat-yhat)*(yhat);
%             else 
%                 g = @(xhat,yhat) (1-xhat-yhat)*(xhat);
%             end
%             Mk(mj,mi) = 2*det(J)*quadrature2D (P(tri(i,1),:), P(tri(i,2),:), P(tri(i,3),:),4,g);
%         end
%     end