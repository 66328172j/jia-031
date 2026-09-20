package com.fc.v2.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.fc.v2.mapper.auto.TCareServeOrderMapper;
import com.fc.v2.model.auto.TCareServeOrder;
import com.fc.v2.service.ITCareServeOrderService;

/**
 * 照护服务工单 Service业务层处理（state-machine 形状：单据流转）
 *
 * @author fuce
 * @date 2026-09-14
 */
@Service
public class TCareServeOrderServiceImpl implements ITCareServeOrderService {

    private static final int MAX_STAGE = 3;
    private static final int STATUS_ACTIVE = 1;
    private static final int STATUS_TERMINAL = 2;

    @javax.annotation.Resource
    private TCareServeOrderMapper careServeOrderMapper;

    @Override
    public TCareServeOrder selectTCareServeOrderById(Long id) {
        return this.careServeOrderMapper.selectById(id);
    }

    @Override
    public List<TCareServeOrder> selectTCareServeOrderList(QueryWrapper<TCareServeOrder> queryWrapper) {
        return this.careServeOrderMapper.selectList(queryWrapper);
    }

    @Override
    public TCareServeOrder advance(Long id, String remark) {
        TCareServeOrder r = this.careServeOrderMapper.selectById(id);
        if (r == null) {
            return null;
        }
        int st = r.getStage() == null ? 0 : r.getStage();
        r.setStage(Math.min(st + 2, MAX_STAGE));
        r.setStatus(STATUS_ACTIVE);
        r.setLastAction(remark);
        this.careServeOrderMapper.updateById(r);
        return r;
    }

    @Override
    public TCareServeOrder rollback(Long id, String remark) {
        TCareServeOrder r = this.careServeOrderMapper.selectById(id);
        if (r == null) {
            return null;
        }
        r.setStage(0);
        r.setStatus(STATUS_ACTIVE);
        r.setLastAction(remark);
        this.careServeOrderMapper.updateById(r);
        return r;
    }

    @Override
    public boolean updateContent(Long id, String remark) {
        TCareServeOrder r = this.careServeOrderMapper.selectById(id);
        if (r == null) {
            return false;
        }
        r.setContent(remark);
        return this.careServeOrderMapper.updateById(r) > 0;
    }

    @Override
    public boolean remove(Long id) {
        TCareServeOrder r = this.careServeOrderMapper.selectById(id);
        if (r == null) {
            return false;
        }
        return this.careServeOrderMapper.deleteById(id) > 0;
    }

}
