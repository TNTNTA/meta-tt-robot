# ROS2 常用命令

ros2测试
```
source /etc/profile.d/ros/setup.sh

export ROS_DOMAIN_ID=1
export ROS_HOME=/opt/ros
export QT_QPA_PLATFORM=eglfs
printenv
export ROS_LOCALHOST_ONLY=1

ros2 run turtlesim turtlesim_node &
ros2 run turtlesim turtle_teleop_key

ros2 run demo_nodes_cpp talker
ros2 run demo_nodes_py listener

// 列出所有当前正常运行的node
ros2 node list 
```