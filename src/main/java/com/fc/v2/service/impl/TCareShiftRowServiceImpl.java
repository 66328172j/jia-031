package com.fc.v2.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.fc.v2.mapper.auto.TCareShiftRowMapper;
import com.fc.v2.model.auto.TCareShiftRow;
import com.fc.v2.service.ITCareShiftRowService;

/**
 * 夜班交接照护记录明细 Service业务层处理（batch-process 形状：整批提交）
 *
 * @author fuce
 * @date 2026-09-14
 */
@Service
public class TCareShiftRowServiceImpl implements ITCareShiftRowService {

    private static final int MAX_ROWS = 500;
    private static final int STATUS_OK = 1;
    private static final int STATUS_FAIL = 2;

    @javax.annotation.Resource
    private TCareShiftRowMapper careShiftRowMapper;

    @Override
    public TCareShiftRow selectTCareShiftRowById(Long id) {
        return this.careShiftRowMapper.selectById(id);
    }

    @Override
    public int submitBatch(String batchNo, List<TCareShiftRow> rows) {
        String no = rows.get(0).getBatchNo();
        java.util.List<TCareShiftRow> errors = new java.util.ArrayList<TCareShiftRow>();
        int seq = 0;
        for (TCareShiftRow r : rows) {
            if (r.getItemCode() == null || r.getItemCode().trim().isEmpty()
                    || r.getQty() == null
                    || r.getQty().compareTo(java.math.BigDecimal.ZERO) <= 0) {
                seq++;
                r.setRowNo(Integer.valueOf(seq));
                r.setBatchNo(no);
                r.setStatus(STATUS_FAIL);
                this.careShiftRowMapper.insert(r);
                errors.add(r);
            }
        }
        if (!errors.isEmpty()) {
            return 0;
        }
        int ok = 0;
        for (TCareShiftRow r : rows) {
            r.setBatchNo(no);
            r.setStatus(STATUS_OK);
            this.careShiftRowMapper.insert(r);
            ok++;
        }
        return ok;
    }

    @Override
    public List<TCareShiftRow> listErrors(String batchNo) {
        return this.careShiftRowMapper.selectList(new QueryWrapper<TCareShiftRow>()
                .eq("batch_no", batchNo).eq("status", STATUS_FAIL));
    }
}
