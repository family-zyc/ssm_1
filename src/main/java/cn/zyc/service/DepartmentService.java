package cn.zyc.service;

import cn.zyc.mapper.DepartmentMapper;
import cn.zyc.pojo.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author zyc
 * @date 2021/6/9
 */
@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;


    public List<Department> getDepts() {
        return departmentMapper.selectByExample(null);
    }
}
