% function xuap2mat(directory)

scene6 = readXUAPFiles('./res_scene6');
scene6 = building_trajectories(scene6);
save scene6 scene6

scene7 = readXUAPFiles('./res_scene7');
scene7 = building_trajectories(scene7);
save scene7 scene7
plot_long_trajectories(scene7,10);

scene8 = readXUAPFiles('./res_scene8');
scene8 = building_trajectories(scene8);
save scene8 scene8
plot_long_trajectories(scene8,10);

