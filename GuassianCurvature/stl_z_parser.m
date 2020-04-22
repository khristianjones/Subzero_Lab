%% Test script 
function MV = stl_z_parser(FV, gC, mC);
% Set boundrary limits here for stl file 
% Units must match up to stl vertex coordinates (see FV.vertices

x_min = min(FV.vertices(:,1));  % These values designate the bounds in the x, y, and z
x_max = max(FV.vertices(:,1)); 
y_min = min(FV.vertices(:,2));
y_max = max(FV.vertices(:,2)); 
z_min = min(FV.vertices(:,3));
z_max = max(FV.vertices(:,3));  % This will be the step profile 

MV = FV;                        % Varible copies the FV file struct which 
                                % contains the faces and vertices (see
                                % gaussianCurvature.m 

step_size = 15;  % set number of steps 
z_step = (z_max-z_min)/step_size; % Finds step size for 
z_entire = (z_max-z_min)/1;   % Entire profile 
z_bounds =  z_min + z_step.*(0:step_size); % Finds bounds for z_profile 


for i = 0:step_size-1 
    i
    

                                
[r] = (FV.vertices(:,1)>x_min & FV.vertices(:,1) < x_max & ...
       FV.vertices(:,2)>y_min & FV.vertices(:,2) < y_max & ...
       FV.vertices(:,3)>z_bounds(i+1) & FV.vertices(:,3) < z_bounds(i+2));
                                
                                % Creates a logical vector that shows all
                                % '1' (true) if vector is within bound, or
                                % '0' (false) if vector is out of bounds 
                                
xFace = r(FV.faces(:,1));           
yFace = r(FV.faces(:,2));           
zFace = r(FV.faces(:,3));
                                % Matches the faces that contain the acceptable vertices 
                                % xFace, yFace, zFace - logical vector N-vertices long
                                

xyzFace = [xFace yFace zFace];   
                                % Creates 3XN long array 

xyzSum = xyzFace(:,1)+xyzFace(:,2)+xyzFace(:,3);

                                % Adds x,y,and z logical vectors up 
                                
MV.faces = FV.faces(find(xyzSum == 3),:);

                                % Chekcs all indices that have all 3
                                % vertices that are within x,y, and z
                                % bounds 

gc_final = gC(unique(MV.faces));
mc_final = mC(unique(MV.faces));
%MV.vertices = MV.vertices(unique(MV.faces),:);
%m = min(MV.faces);
%m = min(m);
%MV.faces = MV.faces - m +1;     


 %% 

% if (abs(min(gc_final))<abs(max(gc_final)))
%     t1 = abs(min(gc_final));
% else
%     t1 = abs(max(gc_final));
% end;
% 
% cmp = linspace(-t1, t1, 100);
% rgb = zeros(100,3);
% for i = 1:50
%     rgb(i,:) = [1 i*.02 i*.02];
% end
% for i = 1:50
%     rgb(50+i,:) = [1-i*.02 1 1-i*.02];
% end
% 
% 
%  
% figure('name','Triangle Mesh Curvature Example','numbertitle','off','color','w');
% % color overlay the gaussian curvature, currently limited to [-1 1] 
% %caxis([-t1 t1]);
% mesh_h=patch(MV,'FaceVertexCdata',gC','facecolor','flat','edgecolor','none','EdgeAlpha',0);
% %set some visualization properties
% set(mesh_h,'ambientstrength',0.1);
% axis('image');
% view([-135 35]);
% camlight('headlight');
% material('dull');
% colorbar();


%% histogram for gc_final and hc_final 

colorcodes = ["#0072BD","#D95319","#EDB120","#7E2F8E","#77AC30","#4DBEEE","#A2142F"];
if (i==0)
    figure();
    legend('-DynamicLegend');
    title('Gaussian Curvature across Z Profile');
    ylabel('Occurances');
    xlabel('mm^-^2');
    hold on;
end;
h = histfit(gc_final)
str1 = num2str(z_bounds(i+1));
str2 = num2str(z_bounds(i+2));
str3 = append(str1,' to ',str2);
    if i+1 > length(colorcodes)
        i_temp = mod(i,length(colorcodes));
        if i_temp == 0
            i_temp = 1;
        end
        set(h(2),'color' ,colorcodes(i_temp),'DisplayName',str3);
    else
        set(h(2),'color', colorcodes(i+1),'DisplayName',str3);
    end;
delete(h(1));

end 

end 