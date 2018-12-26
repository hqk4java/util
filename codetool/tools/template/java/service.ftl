package ${table.servicePackage};

import java.util.List;

import ${table.domainQualifiClassName};
import ${table.voQualifiClassName};
import com.bluedon.common.page.Pagination;
import com.bluedon.common.base.BaseMybatisService;

public interface ${table.serviceName} extends BaseMybatisService<${table.domainName},Integer> {	
    
    public void deleteIds(String ids);
    
    public List<${table.domainName}> selectList(${table.domainName} ${table.domainName?uncap_first});
    
    public Pagination findListByPage(int rows, int page,${table.voName} vo);
   
}

