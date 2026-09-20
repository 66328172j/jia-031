package com.fc.v2.service;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.fc.v2.model.auto.TCareServeRecord;

import java.util.List;

/**
 * 床边照护服务记录单 Service接口
 *
 * @author fuce
 * @date 2026-09-12
 */
public interface ITCareServeRecordService {

    /** 按主键查询 */
    TCareServeRecord selectTCareServeRecordById(Long id);

    /** 按条件查询列表（分页由调用方统一处理） */
    List<TCareServeRecord> selectTCareServeRecordList(Wrapper<TCareServeRecord> queryWrapper);

    /** 新增 */
    int insertTCareServeRecord(TCareServeRecord record);

    /** 修改 */
    int updateTCareServeRecord(TCareServeRecord record);

    /** 批量删除 */
    int deleteTCareServeRecordByIds(String ids);

    /** 按主键删除 */
    int deleteTCareServeRecordById(Long id);
}
