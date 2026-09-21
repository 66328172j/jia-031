-- ncare 长者入住档案种子（床边记录单建档/联动依赖：id=0 在住、id=1 已退住）
-- 阈值 2/6/10 与护理等级档位划分同口径（等于上限取高一档）
INSERT INTO t_care_resident (id, site_no, site_name, site_type, road_name, th1_max, th2_max, th3_max, status, del_flag, create_by, create_time)
VALUES
 (0, 'HZ00', '周桂兰', '半失能', '一楼东区护理分区', 2.00, 6.00, 10.00, 0, 0, 'seed', NOW()),
 (1, 'HZ01', '陈有富', '失能', '二楼西区护理分区', 2.00, 6.00, 10.00, 1, 0, 'seed', NOW())
ON DUPLICATE KEY UPDATE site_name = VALUES(site_name), th1_max = VALUES(th1_max),
 th2_max = VALUES(th2_max), th3_max = VALUES(th3_max), status = VALUES(status), del_flag = 0;
