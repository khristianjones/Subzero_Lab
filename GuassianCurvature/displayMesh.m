function mesh_h = displayMesh(MV, i);  
% inputs - MV file structure 
%        - index to view (1 = full view, 
figure('Name',MV(i).label);
mesh_h=patch('Faces',MV(i).faces, 'Vertices',MV(i).vertices, 'FaceVertexCdata',MV(i).meanCurvature','facecolor','flat','edgecolor','none','EdgeAlpha',0);
%set some visualization properties
set(mesh_h,'ambientstrength',0.1);
axis('image');
view([-135 35]);
camlight('headlight');
material('dull');
colorbar();
end