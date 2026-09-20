package com.fc.v2.controller.admin;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.fc.v2.common.base.BaseController;
import com.fc.v2.common.domain.AjaxResult;
import com.fc.v2.common.domain.ResultTable;
import com.fc.v2.common.log.Log;
import com.fc.v2.model.auto.TCareServeRecord;
import com.fc.v2.service.ITCareServeRecordService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

/**
 * 床边照护服务记录单 Controller
 *
 * @author fuce
 * @date 2026-09-12
 */
@Api(value = "床边照护服务记录单")
@Controller
@RequestMapping("/CareServeRecordController")
public class CareServeRecordController extends BaseController {

    private final String prefix = "admin/careServeRecord";

    @Autowired
    private ITCareServeRecordService careServeRecordService;

    @ApiOperation(value = "分页跳转", notes = "分页跳转")
    @GetMapping("/view")
    @RequiresPermissions("ncare:careServeRecord:view")
    public String view(ModelMap model) {
        return prefix + "/list";
    }

    @Log(title = "床边照护服务记录单集合查询", action = "list")
    @ApiOperation(value = "分页查询", notes = "分页查询")
    @GetMapping("/list")
    @RequiresPermissions("ncare:careServeRecord:list")
    @ResponseBody
    public ResultTable list(TCareServeRecord record) {
        QueryWrapper<TCareServeRecord> queryWrapper = new QueryWrapper<TCareServeRecord>();
        startPage();
        com.github.pagehelper.PageInfo<TCareServeRecord> page =
                new com.github.pagehelper.PageInfo<TCareServeRecord>(careServeRecordService.selectTCareServeRecordList(queryWrapper));
        return pageTable(page.getList(), page.getTotal());
    }

    @Log(title = "床边照护服务记录单新增", action = "add")
    @ApiOperation(value = "新增", notes = "新增")
    @PostMapping("/add")
    @RequiresPermissions("ncare:careServeRecord:add")
    @ResponseBody
    public AjaxResult add(TCareServeRecord record) {
        return toAjax(careServeRecordService.insertTCareServeRecord(record));
    }

    @Log(title = "床边照护服务记录单修改", action = "edit")
    @ApiOperation(value = "修改保存", notes = "修改保存")
    @PostMapping("/edit")
    @RequiresPermissions("ncare:careServeRecord:edit")
    @ResponseBody
    public AjaxResult editSave(TCareServeRecord record) {
        return toAjax(careServeRecordService.updateTCareServeRecord(record));
    }

    @Log(title = "床边照护服务记录单删除", action = "remove")
    @ApiOperation(value = "删除", notes = "删除")
    @DeleteMapping("/remove")
    @RequiresPermissions("ncare:careServeRecord:remove")
    @ResponseBody
    public AjaxResult remove(String ids) {
        return toAjax(careServeRecordService.deleteTCareServeRecordByIds(ids));
    }
}
