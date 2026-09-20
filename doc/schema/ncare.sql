-- ncare 养老机构护理等级评定与照护服务管理 -- schema (jia-031)
-- 列名与基线实体契约（@TableName/@TableField）逐列对齐，改列必须同步实体。
-- 库：jia_031

CREATE TABLE IF NOT EXISTS t_care_assess_task (
  id bigint NOT NULL COMMENT '主键',
  item_no varchar(64) DEFAULT NULL COMMENT '复评任务编号',
  due_at datetime DEFAULT NULL COMMENT '应评时刻',
  amount decimal(12,2) DEFAULT NULL COMMENT '单例评估预估用时(分钟)',
  status int DEFAULT NULL COMMENT '状态 0待派 1已派 2派不出',
  del_flag int DEFAULT '0' COMMENT '删除标记 0正常 1删除',
  create_by varchar(64) DEFAULT NULL COMMENT '创建者',
  create_time datetime DEFAULT NULL COMMENT '创建时间',
  update_by varchar(64) DEFAULT NULL COMMENT '更新者',
  update_time datetime DEFAULT NULL COMMENT '更新时间',
  remark varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='能力复评到期任务条目';

CREATE TABLE IF NOT EXISTS t_care_grade_std (
  id bigint NOT NULL COMMENT '主键',
  rule_code varchar(64) DEFAULT NULL COMMENT '判定线编号',
  rule_name varchar(128) DEFAULT NULL COMMENT '判定线名称',
  th1_max decimal(12,2) DEFAULT NULL COMMENT '一档评分上限',
  th2_max decimal(12,2) DEFAULT NULL COMMENT '二档评分上限',
  th3_max decimal(12,2) DEFAULT NULL COMMENT '三档评分上限',
  eff_start datetime DEFAULT NULL COMMENT '开始施用时刻',
  eff_end datetime DEFAULT NULL COMMENT '让位截止时刻(不含)',
  priority int DEFAULT NULL COMMENT '取优序号(数值越大越优先)',
  status int DEFAULT NULL COMMENT '判定线状况 0现行 1已让位',
  del_flag int DEFAULT '0' COMMENT '删除标记 0正常 1删除',
  create_by varchar(64) DEFAULT NULL COMMENT '创建者',
  create_time datetime DEFAULT NULL COMMENT '创建时间',
  update_by varchar(64) DEFAULT NULL COMMENT '更新者',
  update_time datetime DEFAULT NULL COMMENT '更新时间',
  remark varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='长者能力分级判定线';

CREATE TABLE IF NOT EXISTS t_care_plan_bill (
  id bigint NOT NULL COMMENT '主键',
  bill_no varchar(64) DEFAULT NULL COMMENT '变更申请号',
  node_no int DEFAULT NULL COMMENT '当前签核层 0..2',
  sign_mode int DEFAULT NULL COMMENT '签核模式 0或签 1会签',
  need_count int DEFAULT NULL COMMENT '本层应签人数',
  sign_count int DEFAULT NULL COMMENT '本层已签人数',
  status int DEFAULT NULL COMMENT '申请进展 0签核中 1已核准 2已驳回',
  del_flag int DEFAULT '0' COMMENT '删除标记 0正常 1删除',
  create_by varchar(64) DEFAULT NULL COMMENT '创建者',
  create_time datetime DEFAULT NULL COMMENT '创建时间',
  update_by varchar(64) DEFAULT NULL COMMENT '更新者',
  update_time datetime DEFAULT NULL COMMENT '更新时间',
  remark varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='护理计划变更签批单';

CREATE TABLE IF NOT EXISTS t_care_resident (
  id bigint NOT NULL COMMENT '主键',
  site_no varchar(64) DEFAULT NULL COMMENT '入住编号',
  site_name varchar(128) DEFAULT NULL COMMENT '长者姓名',
  site_type varchar(32) DEFAULT NULL COMMENT '照护类别',
  road_name varchar(128) DEFAULT NULL COMMENT '所属护理分区',
  th1_max decimal(12,2) DEFAULT NULL COMMENT '本长者核定一档项数上限',
  th2_max decimal(12,2) DEFAULT NULL COMMENT '本长者核定二档项数上限',
  th3_max decimal(12,2) DEFAULT NULL COMMENT '本长者核定三档项数上限',
  status int DEFAULT NULL COMMENT '档案状况 0在住 1已退住',
  del_flag int DEFAULT '0' COMMENT '删除标记 0正常 1删除',
  create_by varchar(64) DEFAULT NULL COMMENT '创建者',
  create_time datetime DEFAULT NULL COMMENT '创建时间',
  update_by varchar(64) DEFAULT NULL COMMENT '更新者',
  update_time datetime DEFAULT NULL COMMENT '更新时间',
  remark varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='长者入住档案';

CREATE TABLE IF NOT EXISTS t_care_serve_order (
  id bigint NOT NULL COMMENT '主键',
  biz_no varchar(64) DEFAULT NULL COMMENT '照护工单号',
  stage int DEFAULT NULL COMMENT '当前台阶 0..7',
  status int DEFAULT NULL COMMENT '工单状态 0在办 1已办结 2退回重做',
  content varchar(255) DEFAULT NULL COMMENT '服务留痕',
  last_action varchar(64) DEFAULT NULL COMMENT '最近一次挪动动作',
  del_flag int DEFAULT '0' COMMENT '删除标记 0正常 1删除',
  create_by varchar(64) DEFAULT NULL COMMENT '创建者',
  create_time datetime DEFAULT NULL COMMENT '创建时间',
  update_by varchar(64) DEFAULT NULL COMMENT '更新者',
  update_time datetime DEFAULT NULL COMMENT '更新时间',
  remark varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='照护服务工单';

CREATE TABLE IF NOT EXISTS t_care_serve_record (
  id bigint NOT NULL COMMENT '主键',
  bill_no varchar(64) DEFAULT NULL COMMENT '床边记录单号',
  site_id int DEFAULT NULL COMMENT '在住长者',
  site_no varchar(64) DEFAULT NULL COMMENT '入住编号',
  qty decimal(12,2) DEFAULT NULL COMMENT '本班实测完成项数',
  fine_amt decimal(12,2) DEFAULT NULL COMMENT '加班照护时长(小时)',
  grade_level int DEFAULT NULL COMMENT '完成度达标档',
  status int DEFAULT NULL COMMENT '进展 0待复核 1已复核 2已归卷',
  del_flag int DEFAULT '0' COMMENT '删除标记 0正常 1删除',
  create_by varchar(64) DEFAULT NULL COMMENT '创建者',
  create_time datetime DEFAULT NULL COMMENT '创建时间',
  update_by varchar(64) DEFAULT NULL COMMENT '更新者',
  update_time datetime DEFAULT NULL COMMENT '更新时间',
  remark varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='床边照护服务记录单';

CREATE TABLE IF NOT EXISTS t_care_shift_row (
  id bigint NOT NULL COMMENT '主键',
  batch_no varchar(64) DEFAULT NULL COMMENT '交接批次号',
  row_no int DEFAULT NULL COMMENT '本子上记的行次',
  item_code varchar(64) DEFAULT NULL COMMENT '长者识别码',
  qty decimal(12,2) DEFAULT NULL COMMENT '本班完成照护项数',
  status int DEFAULT NULL COMMENT '行进展 0待处理 1已入库 2已驳回',
  del_flag int DEFAULT '0' COMMENT '删除标记 0正常 1删除',
  create_by varchar(64) DEFAULT NULL COMMENT '创建者',
  create_time datetime DEFAULT NULL COMMENT '创建时间',
  update_by varchar(64) DEFAULT NULL COMMENT '更新者',
  update_time datetime DEFAULT NULL COMMENT '更新时间',
  remark varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='夜班交接照护记录明细';
