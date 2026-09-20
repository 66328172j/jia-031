package com.fc.v2.service;

import com.fc.v2.model.auto.TCarePlanBill;

/**
 * 护理计划变更签批单 Service接口（approval-chain 形状：多阶段签批，无增删改查入口）
 *
 * @author fuce
 * @date 2026-09-14
 */
public interface ITCarePlanBillService {

    /** 按主键回查单据 */
    TCarePlanBill selectTCarePlanBillById(Long id);

    /** 签批一票：返回更新后的单据；被拒返回 null */
    TCarePlanBill approve(Long id, String approver, String comment);

    /** 否决：返回更新后的单据；被拒返回 null */
    TCarePlanBill reject(Long id, String approver, String comment);

    /** 退回上一环节：返回更新后的单据；被拒返回 null */
    TCarePlanBill rollback(Long id, String comment);
}
